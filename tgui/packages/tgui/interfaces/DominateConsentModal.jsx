import { Loader } from "./common/Loader";
import { useBackend } from '../backend';
import { Component, createRef } from 'react';
import { Box, Flex, Section, Button, Stack } from 'tgui-core/components';
import { Window } from '../layouts';

export class DominateConsentModal extends Component {
	render() {
		const { act, data } = useBackend(this.context);
		const { title="", message="", disclaimer="", command=""} = data;
		const windowHeight = 
			180 + 
			(disclaimer.length > 30 ? Math.ceil(disclaimer.length / 4) : 0) + 
			(message.length > 30 ? Math.ceil(message.length / 4) : 0) + 
			(command.length > 30 ? Math.ceil(command.length / 4) : 0)
		return (
			<Window
				title={title}
				width={350}
				height={windowHeight}
				noClose={1}
				>
				<Window.Content>
					<Section fill>
						<Flex direction="column" height="100%">
							<Flex.Item>
								<Box color="red">
									{disclaimer}
								</Box>
							</Flex.Item>
							<Flex.Item grow={1}>
								<Flex
									direction="column"
									className="AlertModal__Message"
									height="100%"
								>
									<Flex.Item>
										<Box m={1} bold>
											{message}
										</Box>
									</Flex.Item>
									<Flex.Item>
										<Box m={1} bold italics color="red">
											{"\""}{command}{"\""}
										</Box>
									</Flex.Item>
								</Flex>
							</Flex.Item>
							<Flex.Item>
								<ConsentButtons/>
							</Flex.Item>
						</Flex>
					</Section>
				</Window.Content>
			</Window>
		);
	}

}


export const ConsentButtons = (props, context) => {
	const { act, data } = useBackend(context)

	const consentButton = (
		<Button
			color="good"
			fluid={1}
			height={2}
			onClick={() => act("consent")}
			pt={0.33}
			textAlign="center"
		>
			{"I CONSENT"}
		</Button>
	)
	const rejectButton = (
		<Button
			color="bad"
			fluid={1}
			height={2}
			onClick={() => act("reject")}
			pt={0.33}
			textAlign="center"
		>
			{"REJECT"}
		</Button>
	)
	const leftButton = consentButton
	const rightButton = rejectButton

	return (
		<Flex direction="row" width="100%">
			<Flex.Item grow>{leftButton}</Flex.Item>
			
			<Flex.Item grow>{rightButton}</Flex.Item>
		</Flex>
	)
}